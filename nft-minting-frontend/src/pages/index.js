import Head from "next/head";
import Mint from "../components/Mint";

export default function Home() {
  return (
    <div>
      <Head>
        <title>NFT Minting</title>
        <meta name="description" content="Mint your NFTs" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main>
        <h1>Mint Your NFT</h1>
        <Mint />
      </main>
    </div>
  );
}
