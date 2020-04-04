import * as React from 'react';
import { Helmet } from 'react-helmet';
import { Layout } from '../components/layout';

const key = `
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
DXXfXLGTmpOkI1Zeub0hqaf65Q==
=ExxU
-----END PGP PUBLIC KEY BLOCK-----
`.trimStart();

export default function Gpg() {
  return  (
    <Layout>
      <Helmet>
        <title>GPG Public Key</title>
      </Helmet>
      <dl>
        <dt>Key</dt>
        <dd>C48DBD97</dd>
        <dt>Fingerprint</dt>
        <dd>52E9 021B 40E0 EE98 9F6D  1A47 1AA5 1329 C48D BD97</dd>
      </dl>
      <pre>
        <code>{key}</code>
      </pre>
    </Layout>
  );
}

