# MyST Publish Github Action

This action enables [publishing MyST content](https://myst-tools.org/) to a [Curvenote site](https://curvenote.com/blog/creating-an-open-research-website). A [Curvenote account](https://curvenote.com/signup) is required, and you must set [your Curvenote API token](https://curvenote.com/docs/cli/authorization#jSdbBAdfKz) as a [github repository secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) named `CURVENOTE_TOKEN`.

You also need a [`myst.yml` file with your site configuration:](https://myst-tools.org/docs/mystjs/quickstart-myst-websites#configuration)

```
myst: v1
...
site:
  template: book-theme
  projects:
    - slug: myst
      path: .
  domains:
    - username-myst_project.curve.space
```

## Example: Deploy on push to main:

```
name: deploy-myst-site
on:
  push:
    branches:
      - main
permissions:
  contents: read
  pull-requests: write
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy 🚀
        uses: curvenote/action-myst-publish
        env:
          CURVENOTE_TOKEN: ${{ secrets.CURVENOTE_TOKEN }}
```

## Example: Deploy preview on PR:

```
name: deploy-myst-site-preview
on:
  pull_request:
    types:
      - opened
      - reopened
      - synchronize
      - closed
permissions:
  contents: read
  pull-requests: write
jobs:
  build-and-deploy-preview:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy 🚀
        uses: curvenote/action-myst-publish
        env:
          CURVENOTE_TOKEN: ${{ secrets.CURVENOTE_TOKEN }}
        with:
          preview: true
          preview_subdomain: username-myst_preview
```

The `preview_subdomain` must be prefixed with your Curvenote username followed by a hyphen; the rest of the subdomain may have letters, numbers, or underscores. Preview domains will be automatically suffixed with pull request number.
