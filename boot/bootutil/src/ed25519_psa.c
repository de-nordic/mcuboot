#include <assert.h>
#include <string.h>
#include <stdint.h>

#include <mcuboot_config/mcuboot_config.h>
#include <psa/crypto.h>
#include <psa/crypto_types.h>

#define SHA512_DIGEST_LENGTH 64


int X25519(uint8_t out_shared_key[32], const uint8_t private_key[32],
           const uint8_t peer_public_value[32]) {
  static const uint8_t kZeros[32] = {0};
}

int ED25519_verify(const uint8_t *message, size_t message_len,
                          const uint8_t signature[64],
                          const uint8_t public_key[32])
{
    /* Set to any error */
    psa_status_t status = PSA_ERROR_BAD_STATE;
    psa_key_attributes_t key_attr = PSA_KEY_ATTRIBUTES_INIT;
    psa_key_id_t kid;

    /* Initialize PSA Crypto */
    status = psa_crypto_init();
    if (status != PSA_SUCCESS) {
        printf("Failed to initialize PSA Crypto\n");
        return 0;
    }

    status = PSA_ERROR_BAD_STATE;

    psa_set_key_type(&key_attr, PSA_KEY_TYPE_ECC_PUBLIC_KEY(PSA_ECC_FAMILY_TWISTED_EDWARDS));
    psa_set_key_usage_flags(&key_attr, PSA_KEY_USAGE_VERIFY_MESSAGE); 
    psa_set_key_algorithm(&key_attr, PSA_ALG_ECDSA(PSA_ALG_SHA_512));
    status = psa_import_key(&key_attr, public_key, 32, &kid);
    if (status != PSA_SUCCESS) {
        printf("Failed to import key with %d\n", status);
    }

    status = psa_destroy_key(kid);
    if (status != PSA_SUCCESS) {
        printf("Failed to destroy key with %d\n", status);
    }
    return 1;
}
