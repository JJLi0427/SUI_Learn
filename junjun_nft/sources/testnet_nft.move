module junjun_nft::testnet_nft {
    use std::string;
    use std::string::{utf8, String};
    use sui::tx_context::{sender};
    use sui::package;
    use sui::display;

    public struct TestnetNFT has key, store {
        id: UID,
        name: String,
        image_url: String,
    }

    // initialize the NFT display fields
    public struct TESTNET_NFT has drop {}

    fun init(otw: TESTNET_NFT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"image_url"),
            utf8(b"description"),
            utf8(b"creator"),
            utf8(b"project_url"),
        ];

        let values = vector[
            utf8(b"{name}"),
            utf8(b"{image_url}"), 
            utf8(b"{description}"),
            utf8(b"Junjun Li"),
            utf8(b"https://github.com/JJLi0427/sui_learn/"),
        ];

        let publisher = package::claim(otw, ctx);

        let mut display = display::new_with_fields<TestnetNFT>(
            &publisher, keys, values, ctx
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx)); // transfer publisher to the caller
        transfer::public_transfer(display, sender(ctx));   // transfer display to the caller

        let nft = TestnetNFT {
            id: object::new(ctx),
            name: string::utf8(b"junjun first nft init"),
            image_url: string::utf8(b"https://avatars.githubusercontent.com/u/112649584?v=4"),
        };

        transfer::public_transfer(nft, sender(ctx)); // transfer NFT to the caller
    }

    // mint NFT function
    #[allow(lint(public_entry))]
    public entry fun mintnft(name: String, image_url: String, ctx: &mut TxContext) {
        let id = object::new(ctx); // new unique ID
        let nft = TestnetNFT { id, name, image_url }; // mint NFT
        transfer::public_transfer(nft, sender(ctx)); // transfer NFT to the caller
    }
}
