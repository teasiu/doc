import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import useBaseUrl from "@docusaurus/useBaseUrl";
import HomepageFeatures from '@site/src/components/HomepageFeatures';
import Amlogic from '@site/src/components/Amlogic';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to={useBaseUrl("devices")}>
            设备支持适配表
          </Link>
        </div>
        <br></br>
        <div className={styles.buttons}>
          <Link className="button button--secondary button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} to="https://www.ecoo.top/download.html">最新固件下载</Link>
          <Link className="button button--secondary button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} to={useBaseUrl("docs/category/机顶盒刷机教程")}>保姆级刷机教程</Link>
        </div>
        <br></br>
        <div className={styles.buttons}>
          <Link
            className="button button--success button--lg"
            to={useBaseUrl("gonggao")}>
            系统最新升级公告
          </Link>
        </div>
      </div>
    </header>
  );
}

function PolicyPersistence() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <div className={styles.policypersistence}>
      <div className="container text--center">
        <div className="row">
          <div className="col" style={{marginBlock: "auto"}}>
            <h3>永久免费的家用 Linux 服务器系统</h3>
            <p>
基于开源 Linux Ubuntu 20.04 LTS 打造的 NAS 系统，海纳思系统。已开发内置丰富的程序和功能，内网穿透，网盘共享，远程下载，Docker安装，个人博客，网络建站，socks5服务，ftp上传下载，webdav接口，终端控制，一键还原，计划任务等等。
            </p>
          </div>
          <div style={{marginInline: "auto"}}>
            <img src="img/about.png" alt="Policy Persistence" width="300" height="500" />
          </div>
        </div>
      </div>
    </div>
  );
}

function PolicyEnforcement() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <div className={styles.policyenforcement}>
      <div className="container text--left">
        <div className="row">
          <div style={{marginInline: "auto"}}>
            <img height="500" width="500" src="img/home.png" alt="homepage" />
          </div>
          <div className="col" style={{marginBlock: "auto"}}>
            <h3>将千家万户的机顶盒打造成一台超低功耗的 Linux 服务器</h3>
            <p>1. 实测功耗约为 3 瓦， 3x24x365÷1000x0.7≈18元/年，一杯奶茶钱，养活它一年。<br />
			2. 支持Docker程序，你可以使用Docker扩展你的需求<br />
			3. 作为家用的文件存储器，文件共享器<br />
			4. 内网穿透跳板机，或P2P把家里的设备跟异地的设备网络组成同一个内网<br />
			5. 博客系统记录你学习和生活的点点滴滴，既能分享，又能保留历史记忆</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function OpenCollective() {
    return (
      <iframe title="Sponsors" src="changeslog.html" style={{width: "100%", height: "1100px", display: "block"}}></iframe>
    );
}

export default function Home() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`e酷网 ${siteConfig.title}`}
      description="海思机顶盒hi3798m">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
        <Amlogic />
        <PolicyPersistence />
        <PolicyEnforcement />
        <OpenCollective />
      </main>
    </Layout>
  );
}
