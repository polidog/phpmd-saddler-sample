#!/usr/bin/env bash

set -eu

if [ -z "${CI_PULL_REQUEST}" ]; then
    REPORTER=Saddler::Reporter::Github::CommitReviewComment
else
    REPORTER=Saddler::Reporter::Github::PullRequestReviewComment
fi

cat phpmd.result.xml \
  | bundle exec pmd_translate_checkstyle_format translate \
  | bundle exec checkstyle_filter-git diff origin/master \
  | bundle exec saddler report --require saddler/reporter/github --reporter $REPORTER