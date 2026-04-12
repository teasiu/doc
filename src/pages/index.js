import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import useBaseUrl from "@docusaurus/useBaseUrl";
import HomepageFeatures from '@site/src/components/HomepageFeatures';
import Amlogic from '@site/src/components/Amlogic';
import styles from './index.module.css';

const stats = [
  { value: '~3W', label: '满载功耗' },
  { value: '4核', label: 'ARM CPU' },
  { value: '1.6GHz', label: '最高主频' },
  { value: '¥18/年', label: '全年电费' },
];

function HomepageHeader() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <header className={styles.heroBanner}>
      <div className={styles.heroGrid} />
      <div className={styles.heroGlow} />
      <div className={styles.heroGlowRight} />
      <div className="container">
        <div className={styles.heroContent}>
          <img
            src="https://doc.ecoo.top/img/hinas01.svg"
            alt="HiNas Logo"
            className={styles.heroLogo}
          />
          <h1 className={styles.heroTitle}>{siteConfig.title}</h1>
          <p className={styles.heroSubtitle}>{siteConfig.tagline}</p>

          <div className={styles.statsRow}>
            {stats.map((s) => (
              <div key={s.label} className={styles.statItem}>
                <span className={styles.statValue}>{s.value}</span>
                <span className={styles.statLabel}>{s.label}</span>
              </div>
            ))}
          </div>

          <div className={styles.buttonGroup}>
            <Link className={clsx(styles.btn, styles.btnPrimary)} to={useBaseUrl('docs/category/机顶盒刷机教程')}>
              📖 保姆级刷机教程
            </Link>
            <Link className={clsx(styles.btn, styles.btnPrimary)} to="download">
              ⬇️ 最新固件下载
            </Link>
            <Link className={clsx(styles.btn, styles.btnPrimary)} to={useBaseUrl('devices')}>
              📋 设备适配表
            </Link>
          </div>
          <div className={styles.buttonGroup}>
            <Link className={clsx(styles.btn, styles.btnSecondary)} to={useBaseUrl('news')}>
              📣 系统升级公告
            </Link>
            <Link className={clsx(styles.btn, styles.btnSecondary)} to={useBaseUrl('docs/intro')}>
              📚 海纳思使用手册
            </Link>
          </div>
        </div>
      </div>
      <div className={styles.heroWave}>
        <svg viewBox="0 0 1440 80" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M0,40 C360,80 1080,0 1440,40 L1440,80 L0,80 Z" fill="var(--ifm-background-color)" />
        </svg>
      </div>
    </header>
  );
}

function SectionPersistence() {
  return (
    <section className={styles.section}>
      <div className="container">
        <div className={styles.sectionInner}>
          <div className={styles.sectionText}>
            <span className={styles.sectionBadge}>✦ 开源 · 免费 · 易用</span>
            <h2 className={styles.sectionTitle}>家用 Linux 服务器系统</h2>
            <p className={styles.sectionDesc}>
              海纳思系统，基于 Ubuntu 20.04 LTS 打造的 NAS 系统，开发者精心内置丰富功能：
            </p>
            <div className={styles.tagCloud}>
              {['内网穿透','网盘共享','远程下载','Docker','个人博客','网络建站','Socks5','FTP','WebDAV','终端控制','一键还原','计划任务'].map(tag => (
                <span key={tag} className={styles.tag}>{tag}</span>
              ))}
            </div>
          </div>
          <div className={styles.sectionImageWrap}>
            <div className={styles.imageGlow} />
            <img src="img/about.png" alt="系统功能概览" className={styles.sectionImg} width="400" height="466" />
          </div>
        </div>
      </div>
    </section>
  );
}

function SectionEnforcement() {
  return (
    <section className={clsx(styles.section, styles.sectionAlt)}>
      <div className="container">
        <div className={clsx(styles.sectionInner, styles.sectionReverse)}>
          <div className={styles.sectionImageWrap}>
            <div className={styles.imageGlow} />
            <img src="img/huawei.png" alt="海思机顶盒" className={styles.sectionImg} height="250" width="400" />
          </div>
          <div className={styles.sectionText}>
            <span className={styles.sectionBadge}>✦ 变废为宝</span>
            <h2 className={styles.sectionTitle}>将机顶盒变成超低功耗服务器</h2>
            <p className={styles.sectionDesc}>
              实测功耗约 3 瓦，全年无休电费 ≈18 元/年，一杯奶茶钱养活它一年。
              盒子 4 核 CPU，主频达 1.4~1.6GHz，流畅运行各类 NAS 程序。
            </p>
            <ul className={styles.featureList}>
              <li>家用存储 / Linux 学习 / 学生技术孵化</li>
              <li>网页建站 / 内网穿透 / 公网映射</li>
              <li>科学上网 / 跑脚本 / 定时任务</li>
            </ul>
            <blockquote className={styles.sectionQuote}>
              "我是小盒子，也是大世界！千家万户都有一个机顶盒，开启您的探索之旅！"
            </blockquote>
          </div>
        </div>
      </div>
    </section>
  );
}

function OpenCollective() {
  return (
    <section className={styles.donateSection}>
      <div className="container">
        <div className={styles.donateTitleWrap}>
          <h2 className={styles.donateTitle}>捐助作者，持续开发</h2>
          <p className={styles.donateSubtitle}>您的支持是项目持续进步的动力</p>
        </div>
        <div className={styles.donateRow}>
          <div className={clsx(styles.donateCard, styles.donateCardBlue)}>
            <div className={styles.donateCardAccent} />
            <div className={styles.donateQrWrap}>
              <img src="img/danote.png" alt="作者赞赏码" className={styles.donateQr} />
            </div>
            <div className={styles.donateCardBody}>
              <h3 className={styles.donateCardTitle}>作者赞赏码</h3>
              <p className={styles.donateCaption}>
                作者"神雕"开发的固件和提供的个人网站，为了持续维护和进步，呼吁有能力的网友支持本站持续运作和固件持续开发更新。不胜感激! 您的捐助将用于本站的服务器架设和固件升级维护。
              </p>
            </div>
          </div>
          <div className={clsx(styles.donateCard, styles.donateCardCyan)}>
            <div className={styles.donateCardAccent} />
            <div className={styles.donateQrWrap}>
              <img src="img/alipay.png" alt="支付宝" className={styles.donateQr} />
            </div>
            <div className={styles.donateCardBody}>
              <h3 className={styles.donateCardTitle}>支付宝 / 远程协助</h3>
              <p className={styles.donateCaption}>
                可以抽出时间为小白网友提供付费远程协助，包括刷机、运维、疑难解决等需求。已组建微信群，加微信注明入群将定期邀请加入。
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default function Home() {
  const { siteConfig } = useDocusaurusContext();
  return (
    <Layout
      title={`e酷网 ${siteConfig.title}`}
      description="海思机顶盒hi3798m">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
        <Amlogic />
        <SectionPersistence />
        <SectionEnforcement />
        <OpenCollective />
      </main>
    </Layout>
  );
}
