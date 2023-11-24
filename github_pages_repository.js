// Octokit.js
// https://github.com/octokit/core.js#readme
const octokit = new Octokit({
    auth: 'YOUR-TOKEN'
  })
  
  await octokit.request('GET /repos/{owner}/{repo}/contents/{path}', {
    owner: 'OWNER',
    repo: 'REPO',
    path: 'PATH',
    headers: {
      'X-GitHub-Api-Version': '2022-11-28'
    }
  })


  //funct to return roll list

  //funct to return picture list after given folder name