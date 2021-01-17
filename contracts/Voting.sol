// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <=0.7.0;

contract Voting {
	//This declares the Ethereum Address of the contract owner
	address public owner;

	//These are state variables to store candidates and voters
	uint256 internal numCandidates;
	uint256 internal numVoters;

	//Events will be used to inform the front-end of activity in our contract
	event AddedCandidate(uint256 candidateId, string name, string proposal);
	event NewVote(uint256 candidateId);

	function vote() public {
		owner = msg.sender;
	}

	//This will be applied to the functions that should only be performed by the owner of the contract. As registering candidates.
	modifier onlyOwner() {
		require(isOwner(), "This operation is OnlyOwner");
		_;
	}

	function isOwner() public view returns (bool) {
		return msg.sender == owner;
	}

	//This will create a hash to assign an Id to a candidate and an address to a voter
	mapping(uint256 => Candidate) public candidatesStore;
	mapping(uint256 => Voter) public votersStore;

	//This defines the Voters structure.
	struct Voter {
		address voterAddress;
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
	function addCandidate(string calldata name, string calldata proposal)
		external
		returns (uint256 candidateId)
	{
		candidateId = numCandidates++;
		candidatesStore[candidateId] = Candidate(name, proposal, true);
		emit AddedCandidate(candidateId, name, proposal);
	}

	function addVote(
		address voterAddress,
		uint256 candidateIdVote,
		uint256 voterId
	) public {
		if (candidatesStore[candidateIdVote].doesExist = true) {
			voterId = numVoters++;
			votersStore[voterId] = Voter(voterAddress, voterId, candidateIdVote);
			emit NewVote(candidateIdVote);
		}
	}

	function totalVotes(uint256 candidateId) public view returns (uint256) {
		uint256 numOfVotes = 0;
		for (uint256 i = 0; i < numVoters; i++) {
			if (votersStore[i].candidateIdVote == candidateId) {
				numOfVotes++;
			}
		}
		return numOfVotes;
	}

	function getNumOfCandidates() public view returns (uint256) {
		return numCandidates;
	}

	function getTotalVoters() public view returns (uint256) {
		return numVoters;
	}

	function getCandidate(uint256 candidateId)
		public
		view
		returns (
			uint256,
			string memory,
			string memory
		)
	{
		return (
			candidateId,
			candidatesStore[candidateId].name,
			candidatesStore[candidateId].proposal
		);
	}
}