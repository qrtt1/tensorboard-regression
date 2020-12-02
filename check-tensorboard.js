const puppeteer = require('puppeteer');
const baseUrl = process.argv[process.argv.length - 1];

const wrongUrls = [];

function checkResult(wrongUrls) {
  if (wrongUrls.length == 0) {
    console.log("All requests are good.")
    process.exit(0);
  } else {
    console.log("Some requests are not good.")
    process.exit(1);
  }
}

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.setDefaultNavigationTimeout(10 * 1000);
  await page.setRequestInterception(true);
  page.on('request', request => {
    if (!request.url().startsWith(baseUrl)) {
      console.log("URL without prefix: " + request.url());
      if (!request.url().includes('/font-roboto/')) {
        wrongUrls.push(request.url())
      }
    }
    request.continue();
  });

  await page.goto(baseUrl);
  await page.waitForNavigation({ waitUntil: 'networkidle0' }),
  await browser.close();
})().then(() => {
  checkResult(wrongUrls);
}).catch((e) => {
  checkResult(wrongUrls);
})