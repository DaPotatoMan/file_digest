const log = console.log.bind(null, '[file_digest_worker]')

/**
 * @param {Uint8Array} data 
 */
async function sha256Digest(data) {
  const hash = await crypto.subtle.digest("SHA-256", data);
  const hashArray = Array.from(new Uint8Array(hash)); // convert buffer to byte array
  const hashHex = hashArray
    .map((b) => b.toString(16).padStart(2, "0"))
    .join(""); // convert bytes to hex string

  return hashHex;
}

onmessage = (event) => {
  const data = event.data

  log('got data', data);

  if (data instanceof Uint8Array) {
    sha256Digest(data).then((digest) => postMessage(digest))
  }
}

log('init')