pragma solidity ^0.5.11;

contract anticounterfeit{
    
    event Added(uint256 index);
    
    uint items;
    
    struct Seller{
        string description;
        address person;
    }mapping (uint256 => Seller) public positions;
    
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
        mapping (uint256 => Seller) positions;
    }
    
    mapping(uint=>Medicine) public AllMedicines;
    
    
     function concat(string memory _a, string memory _b) private pure returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    

    
    function AddMedicine(uint _rate,uint _medicineId,string memory _medicinename,string memory _patchno,string memory _productiondate,string memory _manufacturerlocation,string memory _description)public returns(bool){
            Medicine memory NewMedicine=Medicine(_medicinename,_medicineId,_patchno,msg.sender,_productiondate,_rate,_manufacturerlocation,_description,0);
            AllMedicines[items]=NewMedicine;
            items = items+1;
            emit Added(items-1);
            return true;
            
    }
    
    function SearchMedicine(uint _id)public view returns(string memory){
           require(_id<items);
           string memory output="   Medicine Name : ";
           output=concat(output,AllMedicines[_id].MedicineName);
           output=concat(output,"   Patch No. :");
           output=concat(output,AllMedicines[_id].Patchno);
           output=concat(output,"   Production Date: ");
           output=concat(output,AllMedicines[_id].Productiondate);
           output=concat(output,"   Manfucturer's Location: ");
           output=concat(output,AllMedicines[_id].ManfucturerLocation);
           output=concat(output,"   Manfucturer Information: ");
           output=concat(output,AllMedicines[_id].ManfucturerInfo);
          for (uint256 j=0; j<AllMedicines[_id].totalStates; j++){
            output=concat(output, AllMedicines[_id].positions[j].description);
        }
           return output;
    }
    function addSeller(uint _productId, string memory _date, string memory _supplierlocation) public returns (string memory) {
        require(_productId<items);
        string memory desc="     Date: ";
        desc=concat(desc, _date);
        desc=concat(desc, "      Supplier Location: ");
        desc=concat(desc, _supplierlocation);
        Seller memory newSeller = Seller({person: msg.sender, description: desc});
        AllMedicines[_productId].positions[ AllMedicines[_productId].totalStates ]=newSeller;
        AllMedicines[_productId].totalStates = AllMedicines[_productId].totalStates +1;
        return desc;
    }

}