// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Voting {
    //This declares the Ethereum Address of the contract owner
    address public owner;

    //These are state variables to store candidates and voters
    uint256 public numCandidates;
    uint256 public numVoters;

    //Events will be used to inform the front-end of activity in our contract
    event AddedCandidate(uint256 candidateId);
    event NewVote(uint256 candidateId);

    //Candidate[]public candidates;

    function vote() public {
        owner = msg.sender;
    }

    //This will be applied to the functions that should only be performed by the owner of the contract. As registering candidates.
  modifier onlyOwner() {
    require(isOwner(), "Not the owner");
    _;
  }

      function isOwner() public view returns(bool) {
    return msg.sender == owner;
  }
    //This will create a hash to assign an Id to a candidate and an address to a voter
    mapping(uint256 => Candidate) public candidatesStore;
    mapping(address => Voter) public votersStore;

    //This defines the Voters structure.
    struct Voter {
        address ethAddress;
        uint256 voterId;
        uint256 candidateIdVote;
    }

    //This defines the candidates structure
    struct Candidate {
        string name;
        string proposal;
        bool doesExist;
    }

    //Here we add the functionality of our contract.
    function addCandidate(string memory name, string memory proposal)
        external
        returns (uint256 candidateId)
    {
        candidateId = numCandidates++;
        candidatesStore[candidateId] = Candidate(name, proposal, true);
        emit AddedCandidate(candidateId);
    }

    function addVote(
        address ethAddress,
        uint256 candidateIdVote,
        uint256 voterId
    ) public {
        if (candidatesStore[candidateIdVote].doesExist = true) {
            voterId = numVoters++;
            votersStore[ethAddress] = Voter(
                ethAddress,
                voterId,
                candidateIdVote
            );
            emit NewVote(candidateIdVote);
        }
    }
}

