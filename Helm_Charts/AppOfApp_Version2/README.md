## App of Apps

### 목적
하나의 Helm Template를 Values.yaml만 관리하여 여러개의 App을 생성, 관리하기 위하여 사용

### 개요
`App of Apps`는 Argo CD를 사용하여 여러 Helm 차트를 관리하고 배포할 수 있는 패턴입니다.   
이 패턴을 사용하면 여러 개의 애플리케이션을 하나의 상위 애플리케이션으로 구성하여 효율적으로 관리할 수 있습니다.    
각각의 하위 애플리케이션은 독립적으로 배포되지만, 상위 애플리케이션을 통해 일관되게 관리됩니다.

### 주요 기능
- **중앙 집중식 관리**: 여러 애플리케이션을 하나의 구성 파일로 관리하여 배포 및 업데이트를 간소화합니다.
- **독립적인 배포**: 각 하위 애플리케이션은 독립적으로 배포되며, 특정 애플리케이션만 수정하거나 업데이트할 수 있습니다.
- **Helm 차트 사용**: 각 애플리케이션은 Helm 차트를 기반으로 배포되며, Helm의 강력한 패키징 및 템플릿 기능을 활용합니다.
- **환경 변수 관리**: 각 애플리케이션에 대해 개별적인 `values.yaml` 파일을 사용하여 환경 변수를 관리할 수 있습니다.

### 구조
`App of Apps` 패턴에서는 상위 애플리케이션의 `values.yaml` 파일에 하위 애플리케이션의 정보가 정의됩니다. 예를 들어:

```yaml
apps:
  - name: app1
    valueFiles: values-app1.yaml
  - name: app2
    valueFiles: values-app2.yaml
  - name: app3
    valueFiles: values-app3.yaml
이와 같은 구조를 통해 각 애플리케이션의 이름과 관련된 values.yaml 파일을 지정할 수 있습니다.
```
이와 같은 구조를 통해 각 애플리케이션의 이름과 관련된 `values.yaml` 파일을 지정할 수 있습니다.

### 사용 방법
1. **Helm 차트 구성**: 각 애플리케이션에 대한 Helm 차트를 준비합니다.
2. **App of Apps YAML 생성**: 상위 애플리케이션의 YAML 파일을 작성하여 하위 애플리케이션의 정보를 포함합니다.
3. **Argo CD에 배포**: 상위 애플리케이션을 Argo CD에 배포하여 모든 하위 애플리케이션을 관리합니다.

### 예시
다음은 `App of Apps`의 예시 YAML 파일입니다:
```yaml
spec:
  project: default
  source:
    repoURL: <repository-url>
    targetRevision: main
    path: Helm_Charts/AppOfApp/templates
  destination:
    namespace: web
    server: <k8s-server>
apps:
  - name: app1
    valueFiles: values-app1.yaml
  - name: app2
    valueFiles: values-app2.yaml
  - name: app3
    valueFiles: values-app3.yaml
```
