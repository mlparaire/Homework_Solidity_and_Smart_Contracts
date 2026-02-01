// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;


/* 
* @title: RSA Cryptography
* @author: Tianchan Dong
* @notice: This contracts serves as an illustration of the cryptographic 
* mechanics in a blockchain.
*/ 

contract RSA{

    // Private key: (e, n)
    // Public key: (d, n)
    // For simplicity, the e(encrypt), d(decrypt) and n(modulo) 
    // has been "generated" for you. Do not modify
    uint private ENCRYPT = 7;
    uint private DECRYPT = 3;
    uint private MOD = 33;


    function increment_bytes(bytes memory all_bytes) public pure returns(uint){
        uint sum = 0;
        for(uint i = 0; i < all_bytes.length; i++){
             sum += uint8(all_bytes[i]);
            }
            return sum;
            }

    /// @param data The message to be hashed
    /// @return The hash value, or message digest, of the input
    function hash(string calldata data) public view returns(uint){
         
        uint digest = 0;

        bytes memory str_to_byte = bytes(data);
        // Convert the string to bytes
        digest = increment_bytes(str_to_byte);

        // Add the decimal value of each character together

        // Take the modulo of this sum and return the result
        return digest % MOD; 
    }

        /// @param data the original message
    /// @return a signed message of the *digest*
    function Sign_Message(string calldata data) public view returns(uint){
        // Call the hash function to create the message digest from user data
        uint hashed_message = hash(data);
        // Sign the message with private key (digest^e%n)
        uint signed = (hashed_message ** ENCRYPT) % MOD;

        return signed;
    }

    function verify(string calldata data) public view returns(bool){
        // Create a signed message
        uint signed_message = Sign_Message(data);

        // Decrypt using public key
        uint verify_with_public_key = (signed_message ** DECRYPT)%MOD;

        // Get the digest
        uint digest = hash(data);

        // Check if the decrypted result matches the message digest
        return verify_with_public_key == digest;

    }


}
