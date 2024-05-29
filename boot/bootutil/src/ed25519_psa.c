#include <assert.h>
#include <string.h>
#include <stdint.h>

#include <mcuboot_config/mcuboot_config.h>
#include <psa/crypto.h>

#define SHA512_DIGEST_LENGTH 64


int X25519(uint8_t out_shared_key[32], const uint8_t private_key[32],
           const uint8_t peer_public_value[32]) {
  static const uint8_t kZeros[32] = {0};
}

int ED25519_verify(const uint8_t *message, size_t message_len,
                          const uint8_t signature[64],
                          const uint8_t public_key[32])
{
    psa_status_t status; 

    psa_hash_update(NULL, NULL, 0);
    /* Initialize PSA Crypto */
    status = psa_crypto_init();
    if (status != PSA_SUCCESS) {
        printf("Failed to initialize PSA Crypto\n");
        return;
    }
    return 0;
}
