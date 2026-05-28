// Create a smart contract that logs user workouts and emits events when fitness goals are reached — like 10 workouts in a week or 500 total minutes. Users log each session (type, duration, calories), and the contract tracks progress. Events use *indexed* parameters to make it easy for frontends or off-chain tools to filter logs by user and milestone — just like a backend for a decentralized fitness tracker with achievement unlocks.

// # Concepts You'll Master
// 1. Events
// 2. logging data
// 3. Indexed parameters
// 4. emitting events

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract ActivityTracker {
    struct Workout {
        string workoutType;
        uint256 duration;
        uint256 calories;
    }

    mapping(address => Workout[]) public userWorkouts;
    mapping(address => uint256) public totalWorkouts;
    mapping(address => uint256) public totalMinutes;
    mapping(address => uint256) public totalCalories;

    // Event for workout logging
    event WorkoutLogged(
        address indexed user,
        string workoutType,
        uint256 duration,
        uint256 calories
    );

    event MilestoneReached(address indexed user, string milestone);

    function logWorkout(
        string memory _workoutType,
        uint256 _duration,
        uint256 _calories
    ) public {
        require(_duration > 0, "Duration must be greater than 0");
        require(_calories > 0, "Calories must be greater than 0");

        userWorkouts[msg.sender].push(
            Workout(_workoutType, _duration, _calories)
        );

        totalWorkouts[msg.sender] += 1;

        totalMinutes[msg.sender] += _duration;

        totalCalories[msg.sender] += _calories;

        emit WorkoutLogged(msg.sender, _workoutType, _duration, _calories);

        if (totalWorkouts[msg.sender] == 10) {
            emit MilestoneReached(msg.sender, "Completed 10 Workouts");
        }

        if (totalMinutes[msg.sender] >= 500) {
            emit MilestoneReached(msg.sender, "Reached 500 Workout Minutes");
        }

        if (totalCalories[msg.sender] >= 5000) {
            emit MilestoneReached(msg.sender, "Burned 5000 Calories");
        }
    }

    function getTotalWorkouts() public view returns (uint256) {
        return totalWorkouts[msg.sender];
    }

    function getTotalMinutes() public view returns (uint256) {
        return totalMinutes[msg.sender];
    }

    function getTotalCalories() public view returns (uint256) {
        return totalCalories[msg.sender];
    }

    function getWorkoutCount() public view returns (uint256) {
        return userWorkouts[msg.sender].length;
    }
}
