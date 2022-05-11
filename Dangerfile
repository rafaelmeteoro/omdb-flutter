###################
#
# Check PR quality
#
###################
if github.pr_body.length < 5
  fail "Please provide a summary in the Pull Request description"
end

flutter_lint.report_path = "flutter_analyze_report.txt"
flutter_lint.lint
