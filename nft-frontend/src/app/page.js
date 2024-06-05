import ConnectWallet from "@/components/ConnectWallet";
import Mint from "@/components/Mint";

import Image from "next/image";
export default function Home() {
  return (
    <div className="flex flex-col items-center min-h-screen bg-gray-100 p-4">
      <div className="w-full flex justify-between items-center mb-8 p-4 bg-white shadow-lg rounded-lg">
        <h1 className="text-xl font-bold text-gray-800">Mint your NFT</h1>
        <ConnectWallet />
      </div>
      <Mint />
    </div>
  );
}
