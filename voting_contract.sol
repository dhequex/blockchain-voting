pragma solidity 0.7.0;

contract Voting {

event AddedCandidate(uint candidateId);
event NewVote(uint candidateId);

uint numCandidates;
uint numVoters;

//Candidate[]public candidates;

address owner;
function Vote() public {
    owner = msg.sender;
}

mapping(uint => Candidate) public candidates;
mapping(uint => Voter) public voters;

struct Voter {
string name;
uint voterId;
}

struct Candidate {
string name;
string proposal;
string party;
bool doesExist;
}

function addCandidate(string calldata name, string calldata proposal, string calldata party) external returns(uint candidateId) {
    uint candidateId = numCandidates++;
    candidates[candidateId] = Candidate(name, proposal, party, true);
    emit AddedCandidate(candidateId);

}

function addVote (uint id, string calldata name) external returns(uint voterId){

}

}