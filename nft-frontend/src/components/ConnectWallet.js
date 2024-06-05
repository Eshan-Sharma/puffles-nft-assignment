"use client";
import { useState } from "react";

const ConnectWallet = () => {
  const [connected, setConnected] = useState("Connect Wallet");
  async function connect() {
    if (typeof window.ethereum !== "undefined") {
      try {
        await ethereum.request({ method: "eth_requestAccounts" });
      } catch (error) {
        console.log(error);
      }
      setConnected("Connected");
      const accounts = await ethereum.request({ method: "eth_accounts" });
      console.log(accounts);
    } else {
      setConnected("Please install MetaMask");
    }
  }

  return (
    <button
      onClick={connect}
      className={`px-4 py-2 rounded-lg font-semibold transition ${
        connected === "Connected"
          ? "bg-green-500 text-white"
          : connected === "Please install MetaMask"
          ? "bg-red-500 text-white"
          : "bg-blue-500 text-white hover:bg-blue-600"
      }`}
    >
      {connected}
    </button>
  );
};

export default ConnectWallet;
