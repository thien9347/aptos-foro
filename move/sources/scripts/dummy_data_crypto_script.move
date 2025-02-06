script {

    use std::vector;
    use std::signer;

    use aptosforo_addr::oracle_token;
    use aptosforo_addr::prediction_market;

    fun setup_dummy_data_crypto_category(creator: &signer) {

        let description_bytes_list = vector[
            b"Will Bitcoin hit $100k in 2024?",
            b"US government Bitcoin reserves in 2024?",
            b"Ethereum all time high in 2024?",
            b"Will US sell Silk Road BTC before election?",
            b"Will a new country buy Bitcoin in 2024?",
            b"Will China unban Bitcoin in 2024?",
            b"Will ETH or SOL reach all-time high first?",
            b"Ansem vs. Bitboy - Crypto Fight Night"
        ];

        let outcome_one_bytes_list = vector[
            b"Yes",
            b"Yes",
            b"Yes",
            b"Yes",
            b"Yes",
            b"Yes",
            b"ETH",
            b"Ansem"
        ];

        let outcome_two_bytes_list = vector[
            b"No",
            b"No",
            b"No",
            b"No",
            b"No",
            b"No",
            b"SOL",
            b"Bitboy"
        ];

        let image_url_bytes_list = vector[
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120038/bitcoin-hit-100k.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120037/us-gov-btc-reserves.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120038/ethereum-all-time-high.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120038/silk_road_btc.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120037/new-country-buy-btc.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120037/china-unban-bitcoin.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120037/eth-vs-sol.png",
            b"https://res.cloudinary.com/blockbard/image/upload/c_scale,w_auto,q_auto,f_auto,fl_lossy/v1728120037/ansem-vs-bitboy.png"
        ];

        let categories_bytes_list = vector[
            b"crypto, bitcoin",
            b"crypto, bitcoin",
            b"crypto, ethereum",
            b"crypto, bitcoin, silk road",
            b"crypto, bitcoin",
            b"crypto, bitcoin, china",
            b"crypto, ethereum, solana",
            b"crypto, ansem, bitboy"
        ];

        // mint some oracle tokens
        let mint_amount  = 1000_000_000_000_000;
        oracle_token::public_mint(creator, mint_amount);

        // setup admin properties
        let oracle_token_metadata   = oracle_token::metadata();
        let min_liveness            = 1000;
        let default_fee             = 100;
        let treasury_addr           = signer::address_of(creator);
        let burned_bond_percentage  = 100;
        let swap_fee_percent        = 0;
        let min_liquidity_required  = 10_00;

        // call set_admin_properties
        prediction_market::set_admin_properties(
            creator,
            oracle_token_metadata,
            min_liveness,
            default_fee,
            treasury_addr,
            swap_fee_percent,
            min_liquidity_required,
            burned_bond_percentage
        );

        let initial_liquidity = (100_00_000_000 as u128);

        let i = 0;
        let len = vector::length(&description_bytes_list);
        while (i < len) {
            
            let description         = *vector::borrow(&description_bytes_list, i);
            let image_url           = *vector::borrow(&image_url_bytes_list, i);
            let outcome_one         = *vector::borrow(&outcome_one_bytes_list, i);
            let outcome_two         = *vector::borrow(&outcome_two_bytes_list, i);
            let categories          = *vector::borrow(&categories_bytes_list, i);

            let reward              = 0;
            let required_bond       = 100_000;

            prediction_market::initialize_market(
                creator,
                outcome_one,
                outcome_two,
                description,
                image_url,
                reward,
                required_bond,
                categories
            );

            prediction_market::initialize_pool(creator, i, initial_liquidity);

            i = i + 1;
        }
    }
}
