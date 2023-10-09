import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: '海纳思系统专业版',
    Svg: require('@site/static/img/cpu11.svg').default,
    description: (
      <>
        海思芯片的机顶盒开发了包含wifi功能，打印功能的专业版。
      </>
    ),
  },
 
  {
    title: '海纳思宝塔专用版',
    Svg: require('@site/static/img/cpu12.svg').default,
    description: (
      <>
        内置宝塔程序
      </>
    ),
  },
    {
    title: '海纳思网心云专用版',
    Svg: require('@site/static/img/cpu13.svg').default,
    description: (
      <>
        一个可以赚点小钱钱的系统
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
