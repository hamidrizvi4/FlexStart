pragma solidity ^0.5.11;

contract anticounterfeit{
    
    event Added(uint256 index);
    
    uint items=0;
    
    struct State{
        string description;
        address person;
    }
    
    struct Medicine{
        string MedicineName;
        uint MedicineId;
        string Patchno;
        address Creator;
        string Productiondate;
        uint Rate;
        string ManfucturerLocation;
        string ManfucturerInfo;
        uint256 totalStates;
        mapping (uint256 => State) positions;
    }
    
    mapping(uint=>Medicine) AllMedicines;
    
    
     function concat(string memory _a, string memory _b) public pure returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    

    
    function AddMedicine(uint _rate,string memory _medicinename,string memory _patchno,string memory _productiondate,string memory _manufacturerlocation,string memory _description)public returns(bool){
            Medicine memory NewMedicine=Medicine(_medicinename,items,_patchno,msg.sender,_productiondate,_rate,_manufacturerlocation,_description,0);
            AllMedicines[items]=NewMedicine;
            items = items+1;
            emit Added(items-1);
            return true;
            
    }
    
    function SearchMedicine(uint _id)public view returns(string memory){
           require(_id<items);
           string memory output="Medicine Name ";
           output=concat(output,AllMedicines[_id].MedicineName);
           output=concat(output,"<br>Patch No. :");
           output=concat(output,AllMedicines[_id].Patchno);
           output=concat(output,"<br>Production Date: ");
           output=concat(output,AllMedicines[_id].Productiondate);
           output=concat(output,"<br>Manfucturer's Location: ");
           output=concat(output,AllMedicines[_id].ManfucturerLocation);
           output=concat(output,"<br>Manfucturer Information: ");
           output=concat(output,AllMedicines[_id].ManfucturerInfo);
          for (uint256 j=0; j<AllMedicines[_id].totalStates; j++){
            output=concat(output, AllMedicines[_id].positions[j].description);
        }
           return output;
    }
    function addState(uint _productId, string memory _date, string memory _supplierlocation) public returns (string memory) {
        require(_productId<items);
        string memory desc="<br><br><b>Date: ";
        desc=concat(desc, _date);
        desc=concat(desc, "</b><br>Supplier Location: ");
        desc=concat(desc, _supplierlocation);
        State memory newState = State({person: msg.sender, description: desc});
        AllMedicines[_productId].positions[ AllMedicines[_productId].totalStates ]=newState;
        AllMedicines[_productId].totalStates = AllMedicines[_productId].totalStates +1;
        return desc;
    }

}