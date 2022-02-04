pragma solidity ^0.5.0;

contract Decentragram {
    string public name = "Decentragram";

    //store images
    uint public imageCount = 0;
    mapping(uint => Image) public images;

    struct Image {
      uint id;
      string hash;
      string description;
      uint tipAmount;
      address payable author;
    }

    event ImageCreated(
      uint id,
      string hash,
      string description,
      uint tipAmount,
      address payable author
    );

    event ImageTipped(
      uint id,
      string hash,
      string description,
      uint tipAmount,
      address payable author
    );

    //create images
    function uploadImage(string memory _imgHash,string memory _description) public {

      require(bytes(_imgHash).length > 0);

      require(bytes(_description).length > 0);

      require(msg.sender != address(0x0));

      imageCount ++;

      // Add Image to contract
      images[imageCount] = Image(imageCount,_imgHash,_description,0,msg.sender);
      //emit
      emit ImageCreated(imageCount, _imgHash,_description,0,msg.sender);
    }
    //tip image
    function tipImageOwner(uint _id) public payable {

      require(_id > 0 && _id <= imageCount);
      //fetch the image
      Image memory _image = images[_id];
      //fetch the author
      address payable _author = _image.author;
      //pay the author by sending them ether
      address(_author).transfer(msg.value);
      //add tip amount
      _image.tipAmount = _image.tipAmount + msg.value;
      //update the images
      images[_id] = _image;

      emit ImageTipped(_id, _image.hash, _image.description, _image.tipAmount,_author);
    }
}
