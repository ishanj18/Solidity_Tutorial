// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

// contract demo{
//     string public str="Hello world";
// }
// <----------------------------------------------------------------------->

// //State Variable 
// contract demo{
//     // uint public num=5; //state variable
//         uint public num;

//         // constructor(){
//         //     num=10; //here we can also update our value of num if initailized above
//         // }

//         function setter() public{
//             num=100;
//         }

//         //1.costly
//         //2.permanently stored on blockchain
// }
// <--------------------------------------------------------------------------------------------->

// //Local Variable  
// contract demo{
//     uint c;//state variable 
//     function local() public pure returns (uint){
//         uint a=10;//local variable
//         uint b=20;
//         return a+b;
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //Functions
// contract demo{
//     uint public num;
//     uint abc;//not a public state variable so solidity will not create a automatically getter fun of this variable
//     function setter(uint _num) public{
//         num = _num;
//     }
//     function getter() public view returns (uint){
//         return num;
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //View and Pure keyword
// contract demo{
//     uint public num;
    
//     function setter(uint _num) public{
//         num = _num; //here we are write to the state variable so don't have to use any keyword
//     }
//     function getter() public view returns (uint){
//         return num; //here we are reading from the state variable so we used view keyword 
//     }

//     function random() public pure returns(uint){
//         uint abc; //here we neither reading nor write from the state variable so we used pure keyword
//         abc = 10;
//         return abc;
//     }
// }
// <---------------------------------------------------------------------------------------------------->

// //Constructor in solidity
// contract demo{
//     uint public num=5;

//     constructor(uint _num) {
//         num = _num;
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //Integer Data Type
// contract demo{
//     // uint public num=5;
//     // int public num_var=6;

//    // uint8 public num=266; //this will create error because the range of uint8 is from 0 to 255 similarily in int8 also
// }
// <--------------------------------------------------------------------------------------------->

// //Loops in solidity
// //we also use loop inside a function in solidity can't be created at contract level
// contract loops{
// function Loop() public pure returns(uint){
//     uint sum;
//     uint count;
//     // while(count<5){
//     //     sum=sum+count;
//     //     count++;
//     // }
//     // for( uint count=0;count<5;count++){
//     //     sum=sum+count;
//     // }
//     do{
//         sum=sum+count;
//         count++;
//     }while(count<5);
//     return sum;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Conditionals
// contract conditionals{
//     function checking(uint a ,uint b) public pure returns(uint){
//         if(a>b){
//             return 1;
//             }
//         else if(a==b){
//             return 2;
//         }
//         else{
//             return 0;
//         }
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //Bool Data Type
// contract demo{
//     bool public value=true; //if not intialized then automatically false is given to it

//     function checkEven(uint a) public pure returns(bool){
//         if(a%2==0){
//             return true;
//         }
//         else{
//             return false;
//         }
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //Require in solidity
// //require statement in Solidity is used to validate conditions and revert the transaction if the condition is not met.
// contract demo{
//     function isZero(uint a) public pure returns(bool) {
//         require(a==0, "a is not equal to zero");
//         return true;
//     }

//     //another method
//     function isZeroIF(uint a) public pure returns(bool){
//         if(a==0){
//             return true;
//         }
//         revert("a is not equal to zero");
//         // here if we return "a is not equal to zero" it will not fail the transaction that's why we revert
//     }
//     }
// <--------------------------------------------------------------------------------------------->

// //Modifier in solidity
// //Why Use Modifiers?
// // To avoid repeating code
// // To implement access control
// // To add validation logic
// contract demo{
//     modifier isTrue{
//         require(true==true,"True is not true");
//         _;
//     }

//     function f1() public pure isTrue returns(uint) {
//         return 1;
//     }
//     function f2() public pure isTrue returns(uint) {
//         return 2;
//     }
//     function f3() public pure isTrue returns(uint) {
//         return 3;
//     }
//     function f4() public pure isTrue returns(uint) {
//         return 4;
//     }

//     // //modifier with argument
//     // modifier isEven(uint a){
//     //      require(a%2==0,"Number is not even");
//     //     _;
//     //     }
//     //      function f5(uint a) public pure isEven(a) returns(bool){
//     //         return true;
//     //     }

// }
// <--------------------------------------------------------------------------------------------->

// //Address Data Type
// contract demo{
//     address public addr=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
//     //we see about address data type in table fun and table address
// }
// <--------------------------------------------------------------------------------------------->

// //Fixed Type Arrays
// contract demo{
//     uint[5] public arr; //all initialized to zero.
//     uint[5] public arr1=[10,20,30,40,50];

//     function insert(uint index,uint _item) public{
//         arr1[index]=_item;
//     }
//     function returnArr(uint index) public view returns(uint){
//         return arr1[index];
//     }
//     function returnAllElements() public view returns(uint[5] memory){
//         return arr1; //here arr1 is a reference data type and it is store in the storage area so if we use the reference data type in a function then we have to write memory to generalized it.
//     }
// }  
// <--------------------------------------------------------------------------------------------->

// //Dynamic type arrays
// contract demo{
//     uint[] public arr;

//     function insert(uint item) public {
//         arr.push(item);
//     }

//     function removelast() public{
//         arr.pop();
//     }
//     function lengthofArr() public view returns(uint){
//         return arr.length;
//     }
//     function returnAllElements() public view returns(uint[] memory){
//         return arr;
//     }
// }
// <--------------------------------------------------------------------------------------------->

// //Memory vs Calldata
// contract demo{
//     uint[5] public arr;

//     function insertArr(uint[5] calldata _arr) public{
//         arr = _arr;  //in memory we can change the value of the referenced data type but in calldata we can't it is immutable
// }
// function returnArr() public view returns(uint[5] memory){
//     return arr;  //we can use calldata in the argument not in other case like return and etc;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Memory vs Storage
// contract demo{
// uint[3] public arr=[10,20,30]; //storage, arr is an array that we created at the storage area

// function fmemory() public view {
// uint[3] memory arr1=arr; //arr1 is an arry that we created inside the memory
// arr1[0]=90;
// }

// function fstorage() public {
// uint[3] storage arr2=arr; //arr2 is a pointer to arr
// arr2[0]=90;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Struct in solidity
// contract demo{
// struct Student{
// string name; 
// uint roll; 
// bool pass;
// }

// Student public s1;

// function insert(string memory _name, uint _roll, bool _pass) public{
//     s1=Student (_name,_roll,_pass);
// // s1.name=_name;
// // s1.roll=_roll;
// // s1.pass=_pass;
// }

// function getter() public view returns(Student memory){
// return s1;
// }

// function getName() public view returns(string memory){
// return s1.name;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Array of struct
// contract demo{
// struct Student{
// string name; 
// uint roll; 
// bool pass;
// }

// Student [4] public s;

// function insertStudent(uint index,string memory _name, uint _roll, bool _pass) public {
// s[index]=Student(_name,_roll,_pass);
// }

// function returnStudent(uint index) public view returns (Student memory){
// return s[index];
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Mapping in solidity
// contract demo{
// mapping(uint=>string) public data;

// function insert(uint _roll, string memory _name) public{
//      data[_roll]=_name;
// }

// function getter(uint _roll) public view returns(string memory){
// return data[_roll];
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Mapping with struct
// contract demo{
//      struct Student{
//        string name;
//        uint roll;
//        bool pass;
// }

// mapping(uint=>Student) public data;

// function insert(uint index, string memory _name, uint _roll, bool _pass) public{
//       data[index]=Student(_name,_roll,_pass);
// }

// function returnValue(uint index) public view returns (Student memory){
// return data[index];
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Nested Mapping
// contract demo{
// mapping(uint=>mapping(uint=>bool)) public data;

// function insert(uint row,uint column, bool value)public{
//       data[row][column]=value;
// }

// function returnValue(uint row, uint column) public view returns (bool){
// return data[row][column];
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Mapping with Array
// contract Demo{
// mapping(address=>uint[]) public marks;

// function insertMarks(address _address, uint _marks) public {
// marks[_address].push(_marks);
// }

// function returnMarks(address _address) public view returns (uint[] memory){
// return marks[_address];
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Global Variables
// contract Demo{
// //msg.sender

// function CallerAddress() public view returns (address){
// return msg.sender;
// }

// //timestamp
// function returnBlockTimestamp() public view returns(uint){
// return block.timestamp;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Transfering Ether
// contract Demo{
// //transer ether to my contract

// function sendEtherToContract() public payable {
//  //code
// }

// function balanceOfContract() public view returns(uint){
// return address(this).balance;
// }
// }
// <--------------------------------------------------------------------------------------------->

// //Transfer ether from one address to another address
// contract Demo {
//     function sendETH(address payable receiver) public payable {
//         (bool success, ) = receiver.call{value: msg.value}("");
//         require(success, "Transfer failed");
//     }
// }
// <--------------------------------------------------------------------------------------------->
