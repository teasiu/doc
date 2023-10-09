import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: '海思芯片 Hisilicon 系列',
    Svg: require('@site/static/img/cpu11.svg').default,
    description: (
      <>
        目前已开发适配的海思芯片机顶盒，CPU型号为 hi3798mv100，hi3798mv200，hi3798mv300
      </>
    ),
  },
  {
    title: '晶晨芯片 Amlogic 系列',
    Svg: require('@site/static/img/cpu-amlogic.svg').default,
    description: (
      <>
        已开发适配 S805 玩客云盒子，后续 S905陆续推出。
      </>
    ),
  },
  {
    title: 'AMD Intel 系列',
    Svg: require('@site/static/img/cpu-amd.svg').default,
    description: (
      <>
        即将推出 x86 机型的海纳思系统。
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
