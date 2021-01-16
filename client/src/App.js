import React, { Component } from "react";
import SimpleStorageContract from "./contracts/SimpleStorage.json";
import Voting from "./contracts/Voting.json";
import getWeb3 from "./getWeb3";
import logo from "./Dapp.png";
import "./App.css";
import "./button.js";
import Button from "./button.js";

class App extends Component {
	state = { storageValue: 0, web3: null, accounts: null, contract: null };

	componentDidMount = async () => {
		try {
			// Get network provider and web3 instance.
			const web3 = await getWeb3();

			// Use web3 to get the user's accounts.
			const accounts = await web3.eth.getAccounts();

			// Get the contract instance.
			const networkId = await web3.eth.net.getId();
			const deployedNetwork = Voting.networks[networkId];
			const instance = new web3.eth.Contract(
				Voting.abi,
				deployedNetwork && deployedNetwork.address
			);

			// Set web3, accounts, and contract to the state, and then proceed with an
			// example of interacting with the contract's methods.
			this.setState({ web3, accounts, contract: instance }, this.runVote);
		} catch (error) {
			// Catch any errors for any of the above operations.
			alert(
				`Failed to load web3, accounts, or contract. Check console for details.`
			);
			console.error(error);
		}
	};

	runVote = async () => {
		const { accounts, contract } = this.state;

		// Stores a given value, 5 by default.
		await contract.methods.vote().send({ from: accounts[0] });

		// Get the value from the contract to prove it worked.
		const response = await contract.methods.totalVotes(1).call();

		// Update state with the result.
		this.setState({ storageValue: response });
	};

	runExample = async () => {
		const { accounts, contract } = this.state;

		// Stores a given value, 5 by default.
		await contract.methods.set(5).send({ from: accounts[0] });

		// Get the value from the contract to prove it worked.
		const response = await contract.methods.get().call();

		// Update state with the result.
		this.setState({ storageValue: response });
	};

	render() {
		if (!this.state.web3) {
			return (
				<div className="Loading-logo">
					<img src={logo} />
				</div>
			);
		}
		return (
			<div className="App-header">
				<h1>Cast your Vote</h1>
				<p>Select your party of choice</p>
				<h2>Voting Dapp - Prototype</h2>
				<p>
					If your contracts compiled and migrated successfully, below will show
					a stored value of 5 (by default).
				</p>
				<div>
					<Button></Button>
				</div>
				<p>
					Try changing the value stored on <strong>line 40</strong> of App.js.
				</p>
				<div>The stored value is: {this.state.storageValue}</div>
			</div>
		);
	}
}

export default App;
