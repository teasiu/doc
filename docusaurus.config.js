// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: '海纳思(hinas)使用手册',
  tagline: '一个极低功耗的 Linux 服务器',
  url: 'https://doc.ecoo.top',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'teasiu', // Usually your GitHub org/user name.
  projectName: 'doc', // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'zh-Hans',
    locales: ['zh-Hans'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/teasiu/doc/blob/main/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/teasiu/doc/blob/main/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      metadata: [{name: "keywords", content: "海思机顶盒,hi3798m,nas系统,嵌入式系统,ubuntu移植,arm系统"}],
      navbar: {
        title: 'histb doc',
        logo: {
          alt: 'histb Logo',
          src: './img/logo.svg',
        },
        items: [
          {
            type: 'doc',
            docId: 'intro',
            position: 'left',
            label: '教程手册',
          },
          {
            href: 'https://bbs.histb.com',
            label: '社区论坛',
            position: 'left',
          },
          {to: '/blog', label: '作者博客', position: 'left'},
          {
            href: 'https://github.com/teasiu/doc',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: '教程手册',
                to: '/docs/intro',
              },
            ],
          },
          {
            title: '社区',
            items: [
              {
                label: '海思NAS交流社区',
                href: 'https://bbs.histb.com',
              },
              {
                label: '官方主页',
                href: 'https://www.ecoo.top',
              },
              {
                label: '固件下载',
                href: 'https://dl.ecoo.top:2096',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: '作者博客',
                to: '/blog',
              },
              {
                label: 'GitHub',
                href: 'https://github.com/teasiu/doc',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} www.ecoo.top`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
