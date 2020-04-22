function subscriber_cmd_left_front_callback(msg)
   spdLin = msg["data"]
   sim.setJointTargetVelocity(Motor1, spdLin)
   sim.addStatusbarMessage('cmd_left_front subscriber receiver : spdLin ='..spdLin..'')
end

function subscriber_cmd_left_rear_callback(msg)
   spdLin = msg["data"]
   sim.setJointTargetVelocity(Motor2, spdLin)
   sim.addStatusbarMessage('cmd_left_front subscriber receiver : spdLin ='..spdLin..'')
end

function subscriber_cmd_right_front_callback(msg)
   spdLin = msg["data"]
   sim.setJointTargetVelocity(Motor3, spdLin)
   sim.addStatusbarMessage('cmd_left_front subscriber receiver : spdLin ='..spdLin..'')
end

function subscriber_cmd_right_rear_callback(msg)
   spdLin = msg["data"]
   sim.setJointTargetVelocity(Motor4, spdLin)
   sim.addStatusbarMessage('cmd_left_front subscriber receiver : spdLin ='..spdLin..'')
end 

function getPose(objectName)
   -- This function get the object pose at ROS format geometry_msgs/Pose
   objectHandle=sim.getObjectHandle(objectName)
   relTo = -1
   p=sim.getObjectPosition(objectHandle,relTo)
   o=sim.getObjectQuaternion(objectHandle,relTo)
   return {
      position={x=p[1],y=p[2],z=p[3]},
      orientation={x=o[1],y=o[2],z=o[3],w=o[4]}
   }
end
 
function getTransformStamped(objHandle,name,relTo,relToName)
   -- This function retrieves the stamped transform for a specific object
   t=sim.getSystemTime()
   p=sim.getObjectPosition(objHandle,relTo)
   o=sim.getObjectQuaternion(objHandle,relTo)
   return {
      header={
	 stamp=t,
	 frame_id=relToName
      },
      child_frame_id=name,
      transform={
	 translation={x=p[1],y=p[2],z=p[3]},
	 rotation={x=o[1],y=o[2],z=o[3],w=o[4]}
      }
   }
end
 
function sysCall_init()
   -- The child script initialization
   objectName="Chassis"
   objectHandle=sim.getObjectHandle(objectName)
   -- get left and right motors handles
   Motor1 = sim.getObjectHandle("front_left_joint")
   Motor2 = sim.getObjectHandle("back_left_joint")
   Motor3 = sim.getObjectHandle("front_right_joint")
   Motor4 = sim.getObjectHandle("back_right_joint")
   
   rosInterfacePresent=simROS
   -- Prepare the publishers and subscribers :
   if rosInterfacePresent then
      publisher1=simROS.advertise('/simulationTime','std_msgs/Float32')
      publisher2=simROS.advertise('/pose','geometry_msgs/Pose')
      subscriber1=simROS.subscribe('/cmd_left_front','std_msgs/Float64','subscriber_cmd_left_front_callback')
      subscriber2=simROS.subscribe('/cmd_left_rear','std_msgs/Float64','subscriber_cmd_left_rear_callback')
      subscriber3=simROS.subscribe('/cmd_right_front','std_msgs/Float64','subscriber_cmd_right_front_callback')
      subscriber4=simROS.subscribe('/cmd_right_rear','std_msgs/Float64','subscriber_cmd_right_rear_callback')
   end
end
 
function sysCall_actuation()
   -- Send an updated simulation time message, and send the transform of the object attached to this script:
   if rosInterfacePresent then
      -- publish time and pose topics
      simROS.publish(publisher1,{data=sim.getSimulationTime()})
      simROS.publish(publisher2,getPose("Chassis"))
      -- send a TF
      simROS.sendTransform(getTransformStamped(objectHandle,objectName,-1,'world'))
      -- To send several transforms at once, use simROS.sendTransforms instead
   end
end
 
function sysCall_cleanup()
    -- Following not really needed in a simulation script (i.e. automatically shut down at simulation end):
    if rosInterfacePresent then
        simROS.shutdownPublisher(publisher1)
        simROS.shutdownPublisher(publisher2)
        simROS.shutdownSubscriber(subscriber1)
    end
end
