import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Base on Linux Ubuntu 20.04 LTS',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        基于 ubuntu linux 打造一个优秀的 nas 系统。内置丰富的功能，
        网盘，建站，上传下载，穿透等，不仅能满足你家用小型服务器的
        要求，还可以通过 ubuntu 丰富的软件仓库安装你需要的软件。
      </>
    ),
  },
  {
    title: 'Arm v7/v8 4core 1.5Hz CPU',
    Svg: require('@site/static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        适配的海思 hi3798m 芯片盒子，高达 1.5hz 的四核 CPU，1-2G运存，8G闪存，
        让你轻松应对各项运行环境需求。hi3798mv200/300的盒子，支持 arch64 系统，
        日常只有2-3瓦的功耗，轻易超越你的需求。
      </>
    ),
  },
  {
    title: 'Support Docker 20.18',
    Svg: require('@site/static/img/undraw_docusaurus_react.svg').default,
    description: (
      <>
        Extend or customize your website layout by reusing React. Docusaurus can
        be extended while reusing the same header and footer.
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
