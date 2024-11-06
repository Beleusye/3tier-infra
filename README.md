# 3-Tier 인프라 구성

![aws-3tier drawio (1)](https://github.com/user-attachments/assets/840fd20d-3916-46bf-94de-eec66ef0c208)

## 프로젝트 설명

이 프로젝트는 **3-Tier 아키텍처**를 기반으로 하여 **Web**, **Application (WAS)**, **Database** 계층을 AWS 상에 구성한 인프라 자동화 프로젝트입니다. Terraform을 사용하여 인프라를 코드로 관리하고 배포하였으며, 계층별로 AWS 서비스에 분산하여 안정성과 보안을 강화했습니다.

### 주요 기능 (Features)

- **인프라 코드화(IaC)**: Terraform을 사용해 인프라를 코드로 관리하여 효율성을 극대화했습니다.
- **확장성**: 웹 및 애플리케이션 계층에서 Auto Scaling을 지원하여 트래픽 변화에 유연하게 대응할 수 있도록 구성하였습니다.
- **보안성**: 최소 권한 원칙을 적용하여 보안 그룹을 설정하고, 각 계층 간의 접근 제어를 강화했습니다.

## 어플리케이션

- **Petclinic** (https://github.com/spring-projects/spring-petclinic): Spring 프레임워크를 활용한 Petclinic 애플리케이션을 배포하였습니다.

## 새로 배운 기술

프로젝트를 진행하면서 새로운 기술을 접하고 사용해 보았습니다.

- **Terraform Cloud**
- **AWS Certificate Manager(ACM)**

## 결과
- `sh-kim.store` 도메인으로 접속하면 petclinic 웹 사이트에 접속 가능합니다.
- 80포트로 접속하면 443포트로 리디렉션하여 보안 접속이 가능합니다.

![petclinic](https://github.com/user-attachments/assets/31cb160d-8209-4d92-8c0e-f4a33de7b288)

## 노션
- https://strong-meadow-e0d.notion.site/Terraform-3-tier-12328773fc968051b652f900c92340af?pvs=4
