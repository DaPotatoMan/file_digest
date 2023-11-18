const log = console.log.bind(null, '[file_digest_worker]')

/**
 * @param {String} type 
 * @param {Uint8Array} data 
 */
async function getDigest(type, data) {
  const hash = await crypto.subtle.digest(type, data);
  const hashArray = Array.from(new Uint8Array(hash));
  const hexDigest = hashArray.map(byte => byte.toString(16).padStart(2, '0')).join('');

  return hexDigest;
}

onmessage = (event) => {
  /**
   * @typedef {Object} Message
   * @property {String} type - Type of hash
   * @property {Uint8Array} data 
   */

  /** @type {Message} */
  const { type, data } = event.data
  const ALLOWED_HASH = ['MD5', 'SHA-256', 'SHA-512']

  if (!ALLOWED_HASH.some(e => e === type))
    throw new Error(`Provided Hash function [${type}] is not yet supported`)

  if (data instanceof Uint8Array === false)
    throw new Error(`Provided data type (${typeof data}) is not Uint8Array`)


  log('Parsing digest', { type, data });
  getDigest(type, data).then((digest) => postMessage(digest))
}

log('init')