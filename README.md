# sui_learn
Learning SUI course &amp; finish homework

## Module 1

### Install & Setup

```shell
# MacOS
brew install sui
# Other OS: https://docs.sui.io/guides/developer/getting-started/sui-install

# Connect SUI
sui client
# then follow instruction setup env, default connect to testnet

# Add your address
sui keytool import <INPUT_STRING> <KEY_SCHEME> [DERIVATION_PATH]
sui client addresses # show all your address

# Switch env or address
sui client switch --env <ALIAS>
sui client switch --address <ALIAS>
```

### Mint NFT
```shell
cd junjun_nft
sui move build
sui client publish # Publish package, init first nft
sui client call --package <package_id> --module testnet_nft --function mintnft --args <nft_name> <nft_description> <image_url>
```