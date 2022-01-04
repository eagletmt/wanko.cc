import { StaticQuery, graphql } from 'gatsby';
import * as React from 'react';
import { Helmet } from 'react-helmet';
import { Layout } from '../components/layout';

export default function Gpg() {
  const query = graphql`
  query GpgQuery {
    file(sourceInstanceName: {eq: "static"}, relativePath: {eq: "gpg.txt"}) {
      childPlainText {
        content
      }
    }
  }
  `;
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
        <code><StaticQuery query={query} render={(data) => data.file.childPlainText.content}/></code>
      </pre>
    </Layout>
  );
}

