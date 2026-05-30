// Build a modular profile system for a Web3 game. The core contract stores each player's basic profile (like name and avatar), but players can activate optional 'plugins' to add extra features like achievements, inventory management, battle stats, or social interactions. Each plugin is a separate contract with its own logic, and the main contract uses `delegatecall` to execute plugin functions while keeping all data in the core profile. This allows developers to add or upgrade features without redeploying the main contract—just like installing new add-ons in a game. You'll learn how to use `delegatecall` safely, manage execution context, and organize external logic in a modular way.

// # Concepts you will master
// 1. delegatecall
// 2. code execution context
// 3. libraries

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

// PLUGIN CONTRACT
contract AchievementPlugin {
    uint public achievements;

    function unlockAchievement() public {
        achievements += 1;
    }
}

// MAIN CONTRACT
contract PluginStore {
    string public playerName;

    string public avatar;

    uint public achievements;

    address public owner;

    address public plugin;

    constructor() {
        owner = msg.sender;
    }

    function createProfile(string memory _name, string memory _avatar) public {
        playerName = _name;

        avatar = _avatar;
    }

    function setPlugin(address _plugin) public {
        require(msg.sender == owner, "Only owner can set plugin");

        plugin = _plugin;
    }

    function usePlugin() public {
        require(plugin != address(0), "Plugin not set");

        (bool success, ) = plugin.delegatecall(
            abi.encodeWithSignature("unlockAchievement()")
        );

        require(success, "Plugin execution failed");
    }

    function viewProfile()
        public
        view
        returns (string memory, string memory, uint)
    {
        return (playerName, avatar, achievements);
    }
}
