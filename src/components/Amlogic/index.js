import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: '海纳思系统专业版',
    Svg: require('@site/static/img/cpu-ecoo.svg').default,
    description: (
      <>
        包含wifi功能，打印功能，内网穿透的专业版。<br />
        <a href="https://www.ecoo.top/professional.html" target="_blank">更多详情</a>
      </>
    ),
  },
 
  {
    title: '海纳思宝塔专用版',
    Svg: require('@site/static/img/cpu-baota.svg').default,
    description: (
      <>
        内置宝塔程序,预编译并内置全家桶 LNMP 套件。<br />
        <a href="https://www.ecoo.top/baota" target="_blank">更多详情</a>
      </>
    ),
  },
    {
    title: '海纳思网心云专用版',
    Svg: require('@site/static/img/cpu-hinas.svg').default,
    description: (
      <>
        可以赚点小钱钱的系统，优化后运行容器魔方镜像。<br />
        <a href="/gonggao/#3-网心云专用固件付费10元一键切换安装" target="_blank">更多详情</a>
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
