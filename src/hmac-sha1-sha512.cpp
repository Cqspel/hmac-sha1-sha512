//============================================================================
// Name        : test-hmac-digest.cpp
// Author      : cqspel
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <Poco/HMACEngine.h>
#include <Poco/SHA1Engine.h>
#include <Poco/Crypto/DigestEngine.h>
#include <iostream>
#include <string.h>
#include <openssl/hmac.h>

using Poco::DigestEngine;
using Poco::HMACEngine;
using Poco::SHA1Engine;

int main(int argc, char** argv) {
    std::string basestring("/call/call-api-id/1234567890/timestamp/1486761150/nonce/45egwr34/msisdn/79267765953");
    std::string passphrase("s3cr3t1123124234234124dfsdf");
    HMACEngine<SHA1Engine> hmac(passphrase);
    hmac.update(basestring);

    std::string digestString(DigestEngine::digestToHex(hmac.digest()));

    std::cout << "HMAC-SHA1 digest:   " << digestString << std::endl;

    unsigned char* digestOpenssl;
    // e.g EVP_md5(), EVP_sha224, EVP_sha512, etc
    digestOpenssl = HMAC(EVP_sha512(), passphrase.c_str(), passphrase.length(), reinterpret_cast<const unsigned char*>(basestring.c_str()), basestring.length(), nullptr, nullptr);

    char sha512String[64];
    for (int i = 0; i < 64; i++)
        sprintf(&sha512String[i * 2], "%02x", digestOpenssl[i]);

    printf("HMAC-SHA512 digest: %s\n", sha512String);

    return 0;

}
