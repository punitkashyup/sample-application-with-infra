flowchart TB
    subgraph Azure["Azure Cloud"]
        RG["Resource Group"]
        
        subgraph AKS["AKS Cluster"]
            NP["Default Node Pool"]
            ANP["Additional Node Pools"]
            
            subgraph K8S["Kubernetes Resources"]
                NING["NGINX Ingress Controller"]
                CERT["Cert Manager"]
                CLSI["ClusterIssuer"]
                
                subgraph NS["Custom Namespace"]
                    MODB["MongoDB"]
                end
            end
        end
        
        subgraph Backend["Terraform Backend"]
            SA["Storage Account"]
            CONT["Blob Container"]
            STATE["State File"]
        end
    end
    
    RG --> AKS
    RG --> Backend
    SA --> CONT
    CONT --> STATE
    NP --> K8S
    ANP --> K8S
    NING --> CERT
    CERT --> CLSI