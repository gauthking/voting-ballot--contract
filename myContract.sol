pragma solidity ^0.8.4;

contract myContract {
    uint256 private XYZvotes;
    uint256 private ABCvotes;
    uint256 private EYKvotes;

    struct voterInfo {
        string voter;
        string votedParty;
        uint256 age;
    }

    voterInfo[] voterArray;

    mapping(address => bool) private isVerified;

    modifier voterValidation(address _add, uint256 _age) {
        require(isVerified[_add] != true, "You have already voted");
        _;
        require(_age >= 18, "Candidate must be 18 years or older");
    }

    function voterSystem(
        string calldata _votername,
        string calldata _party,
        uint256 _age
    ) public voterValidation(msg.sender, _age) {
        if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("XYZ"))
        ) {
            XYZvotes++;
            voterArray.push(voterInfo(_votername, _party, _age));
        } else if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("ABC"))
        ) {
            ABCvotes++;
            voterArray.push(voterInfo(_votername, _party, _age));
        } else if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("EYK"))
        ) {
            EYKvotes++;
            voterArray.push(voterInfo(_votername, _party, _age));
        }
    }

    function returnNumberOfVotes(string calldata _party)
        public
        view
        returns (uint256 s)
    {
        if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("XYZ"))
        ) {
            return XYZvotes;
        } else if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("ABC"))
        ) {
            return ABCvotes;
        } else if (
            keccak256(abi.encodePacked(_party)) ==
            keccak256(abi.encodePacked("EYK"))
        ) {
            return EYKvotes;
        }
    }

    function returnVoterInfo(string calldata _votername)
        public
        view
        returns (string memory d)
    {
        for (uint256 i = 0; i < voterArray.length; i++) {
            if (
                keccak256(abi.encodePacked(voterArray[i].voter)) ==
                keccak256(abi.encodePacked(_votername))
            ) {
                return voterArray[i].votedParty;
            }
        }
    }
}
