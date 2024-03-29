abbr --add gccl  'gcloud config list'
abbr --add gccca 'gcloud config configurations activate'
abbr --add gcpn  'gcloud projects describe --format "get(projectNumber)"'
abbr --add gcnsl 'gcloud compute networks subnets list'

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

function gcccc --argument-names project
  if test -z $project
    echo 'No project specified'
    return 1
  end
  gcloud config configurations create $project
  gcloud config set account $USER@google.com
  gcloud config set project --quiet $project
  gcloud config set disable_prompts true
  gcloud config set survey/disable_prompts true
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
