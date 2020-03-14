import * as React from 'react';
import { Helmet} from 'react-helmet';
import { Link } from 'gatsby';
import { Layout } from '../components/layout';

const links = [
  'https://twitter.com/eagletmt',
  'https://github.com/eagletmt',
  'https://eagletmt.hateblo.jp/',
  'https://eagletmt.github.io/contests/',
  'https://telop-anime.tumblr.com',
  'https://mypage.aikatsu.com/mypages/index/FVZ8qBNy3OCCQBzd/',
].map((link) => {
  return <li key={link}><a href={link}>{link}</a></li>;
});

export default function Index() {
  return (
    <Layout>
      <Helmet>
        <title>wanko.cc</title>
      </Helmet>
      <div id='top-links'>
        <ul>
          {links}
        </ul>
      </div>
      <div>
        <ul>
          <li>
            <Link to='/gpg'>GPG Public Key</Link>
          </li>
          <li>
            <Link to='/salary'>Salary</Link>
          </li>
          <li>
            <Link to='/payment'>送金方法</Link>
          </li>
        </ul>
      </div>
    </Layout>
  );
}
