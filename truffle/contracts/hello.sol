// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
pragma experimental ABIEncoderV2;
contract Hello {

   address contractOwner;
   uint public permitno=0;

   // struct Date{
   //    uint day;
   //    uint month;
   //    uint year;
   // }

   struct user{
      string userId;
      uint permitno;
      string division;
      string signatory;
      //string hash2;
      string name;
      uint startDate;
      uint endDate;
      bool canceled;
   }

   mapping(bytes32=>user)public userDetails;

   constructor() public{
      contractOwner=msg.sender;
      permitno++;
   }


   function issuePermit(string memory _userId,string memory _division,string memory _name,string memory _signatory) public returns(bytes32){
      permitno++;
      bool _canceled=false;
      uint _start=block.timestamp;// current timestamp
      uint _end=_start+31556926; //1 year valid
      string memory combined=string(abi.encodePacked(_userId,_division,permitno,_signatory,_start,_end));
      bytes32 _hash1=sha256(abi.encode(combined));
      //bytes32 _hash2=sha256(_hash1);
      if(notexist(_hash1)==true){
      userDetails[_hash1]=user(_userId,permitno,_division,_signatory,_name,_start,_end,_canceled); //["Asddsadsk6484"]=>("raman","55","A","ramesh","hash for mongo")
      }
      return _hash1;
   }

   function isValid(bytes32 _hash1) view public returns(bool){
      bytes memory tempEmptyStringTest = bytes(userDetails[_hash1].userId); // Uses memory
      bool temp=(tempEmptyStringTest.length==0?false:true);
      if(temp==true && block.timestamp<userDetails[_hash1].endDate && userDetails[_hash1].canceled==false ){
         return true;
      }
      return false;
   } 
   
   function notexist(bytes32 _hash1) view public returns(bool){
      bytes memory tempEmptyStringTest = bytes(userDetails[_hash1].userId); // Uses memory
      return (tempEmptyStringTest.length==0?true:false);
   }

   function all(bytes32[]  memory _hashes) public view returns(user[] memory){
      uint size=permitno;
      user[] memory _allUser=new user[](size);
      for(uint i=0;i<permitno;i++){
         bytes32 _userhash=_hashes[i];
         user memory a=userDetails[_userhash];
         _allUser[i]=user(a.userId,a.permitno,a.division,a.signatory,a.name,a.startDate,a.endDate,a.canceled);
      }
      return _allUser;
   }

   // function updatePermit(bytes32 _hash1,uint _newend)public{

   // }
   function cancelPermit(bytes32 _hash1)public{
      userDetails[_hash1].canceled=true;
   }

   //getUserData , UpdatePermit, cancelPermit, getDataLocationWise

}