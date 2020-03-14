import * as React from 'react';
import { Helmet} from 'react-helmet';
import { Layout } from '../components/layout';

export default function Payment() {
  return  (
    <Layout>
      <Helmet>
        <title>送金手段</title>
      </Helmet>
      <p>上にあるほど好ましいです。</p>
      <ol>
        <li>Amazon ギフト券: amazon-gift@wanko.cc</li>
        <li>Kyash ID: eagletmt</li>
      </ol>
    </Layout>
  );
}

