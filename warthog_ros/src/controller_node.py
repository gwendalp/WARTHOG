#! /usr/bin/env python

import rospy
import numpy as np
from std_msgs.msg import Float64
from geometry_msgs.msg import Twist


def cmd_callback(data):
    global u1, u2, u3, u4
    vel = 15 
    theta = data.angular.z
    theta = -3*theta
    speed = data.linear.x
    if data.angular.z != 0:
        u1, u3 = theta, theta
        u2, u4 = -theta, -theta
    else:
        u1, u2, u3, u4 = vel*speed, vel*speed, vel*speed, vel*speed





if __name__ == "__main__":
    # Variables
    
    u1, u2, u3, u4 = 0, 0, 0, 0

    # ROS
    rospy.init_node('controller_node')
    
    cmd_left_front = rospy.Publisher("cmd_left_front", Float64, queue_size=1000)
    cmd_left_rear = rospy.Publisher("cmd_left_rear", Float64, queue_size=1000)
    cmd_right_front = rospy.Publisher("cmd_right_front", Float64, queue_size=1000)
    cmd_right_rear = rospy.Publisher("cmd_right_rear", Float64, queue_size=1000)
    
    rospy.Subscriber("/cmd_vel", Twist, cmd_callback, queue_size=1)
    
    r = rospy.Rate(20)

    msg = Twist()

    while not rospy.is_shutdown():
        # Computing the command to set
        
        cmd_left_front.publish(u1)
        cmd_right_front.publish(u2)
        cmd_left_rear.publish(u3)
        cmd_right_rear.publish(u4)

        # Sleeping
        r.sleep()