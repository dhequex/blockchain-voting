const Voting = artifacts.require("Voting");
const truffleAssert = require("truffle-assertions");

contract("Voting", accounts => {
	let contract;
	const voterName = "Bob";
	const candidateName = "Alice";
	const candidateProposal = "A blockchain Voiting System for All";
	const owner = accounts[0];
	const voter = accounts[1];
	const notOwner = accounts[2];

	before("setup contract", async () => {
		console.log("voting deployed");
		contract = await Voting.deployed();
	});

	it("Should allow to create a candidate", async () => {
		const result = await contract.addCandidate(
			candidateName,
			candidateProposal,
			{
				from: owner,
			}
		);

		truffleAssert.eventEmitted(result, "AddedCandidate", ev => {
			console.log("Candidate Test");
			return (
				ev.candidateName == candidateName &&
				ev.candidateProposal == candidateProposal
			);
		});
	});
});
