abbr --add --global gccl  'gcloud config list'
abbr --add --global gccca 'gcloud config configurations activate'
abbr --add --global gcpn  'gcloud projects describe --format "get(projectNumber)"'

function gcccl
  gcloud config configurations list --format \
    (string join '' 'table[box](' \
      'format("{}", is_active).sub("True", "✓").sub("False", ""):label="A",' \
      'name:label=Configuration,' \
      'format("http://pantheon/home/dashboard?project={}", properties.core.project):label="Console"' \
      ')')
end

function gcpls
  gcloud projects list \
    --filter 'projectId ~ .*serban.*' \
    --format 'table[box](parent.type:label=PARENT_TYPE,parent.id:label=PARENT_ID,projectNumber,projectId,name)'
end

function gcpd --argument-names project
  if test -z $project
    echo 'No project specified'
    return 1
  end
  gcloud projects delete --quiet $project
  gcloud config configurations activate default
  gcloud config configurations delete --quiet $project
end
