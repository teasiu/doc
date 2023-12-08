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
		<div style={{ display: 'flex', alignItems: 'center' }}>
          <img src="img/logo.svg" alt="logo" />
         </div>
            <h1 className="hero__title">{siteConfig.title}</h1>
            <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link className="button button--secondary button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} to={useBaseUrl("docs/category/机顶盒刷机教程")}>保姆级刷机教程</Link>
          <Link className="button button--secondary button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} to="download">最新固件下载</Link>
          <Link className="button button--secondary button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} to={useBaseUrl("devices")}>设备支持适配表</Link>
        </div>
        <br></br>
        <div className={styles.buttons}>
          <Link
            className="button button--success button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} 
            to={useBaseUrl("news")}>
            系统最新升级公告
          </Link>
          <Link
            className="button button--success button--lg" style={{marginTop: "1rem", marginRight: ".5rem", marginLeft: ".5rem", display: "flex"}} 
            to={useBaseUrl("docs/intro")}>
            海纳思系统使用手册
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
            <h2>开源，免费，易用的家用 Linux 服务器系统</h2>
            <p>
			海纳思系统，一个基于开源 Linux Ubuntu 20.04 LTS 打造的 NAS 系统，<br />
			开发者精心打造，已开发和内置丰富的程序和功能，内网穿透，网盘共享，<br />
			远程下载，Docker安装，个人博客，网络建站，socks5服务，ftp上传下载，<br />
			webdav接口，终端控制，一键还原，计划任务等等。<br />
            </p>
          </div>
          <div style={{marginInline: "auto"}}>
            <img src="img/about.png" alt="Policy Persistence" width="400" height="466" />
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
      <div className="container text--center">
        <div className="row">
          <div style={{marginInline: "auto"}}>
            <img height="250" width="400" src="img/huawei.png" alt="homepage" />
          </div>
          <div className="col" style={{marginBlock: "auto"}}>
            <h2>将千家万户的机顶盒打造成一台超低功耗的 Linux 服务器</h2>
            <p>实测功耗约为 3 瓦， 3x24x365÷1000x0.7≈18元/年，一杯奶茶钱，养活它一年。<br />
			普遍盒子4核心CPU，内核频率高达1.4GHz-1.6GHz，流畅运行各项 NAS 程序。<br />
			作为家用存储机，Linux 学习机，学生技术孵化机，网络下载机，组网跳板机，均可。<br />
			应用于网页建站，内网穿越，公网映射，科学上网，跑脚本，定时任务等，更佳。<br />
			我是小盒子，也是大世界！千家万户都有一个机顶盒，开启您的探索之旅！</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function OpenCollective() {
    return (
      <iframe title="Sponsors" src="juanzhu.html" style={{width: "100%", height: "900px", display: "block"}}></iframe>
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
