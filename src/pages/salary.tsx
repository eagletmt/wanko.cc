import * as React from 'react';
import { Helmet} from 'react-helmet';
import { Layout } from '../components/layout';

const data = [{
  year: '2014',
  base: 480,
}, {
  year: '2015',
  base: 510,
}, {
  year: '2016',
  base: 560,
}, {
  year: '2017',
  base: 768,
  bonus: 50,
}, {
  year: '2018 (first half)',
  base: 900,
}, {
  year: '2018 (second half)',
  base: 950.1,
}, {
  year: '2019',
  base: 1000.2,
}];

export default function Salary() {
  const rows = data.map((salary) => {
    return (
      <tr key={salary.year}>
        <td>{salary.year}</td>
        <td>{salary.base}</td>
        <td>{salary.bonus || 0}</td>
      </tr>
    );
  });
  return (
    <Layout>
      <Helmet>
        <title>Salary</title>
      </Helmet>
      <table>
        <thead>
          <tr>
            <th>Year</th>
            <th>Base</th>
            <th>Bonus</th>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </table>
    </Layout>
  );
}

