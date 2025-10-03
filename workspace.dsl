workspace {
    model {
        # Actors
        admin = person "Administrador"
        client = person "Cliente Zero Stress"
        staff = person "Personal Operativo"
        
        # External Systems
        whatsapp = softwareSystem "WhatsApp" "Plataforma de mensajería (WhatsApp Business API)" "external"
        llm = softwareSystem "LLM" "Sistema de IA" "external"
        
        # Software System
        zeroStressSystem = softwareSystem "Zero Stress Pool Management System" {
            
            # Frontend
            webApp = container "Web Application" {
                description "SPA responsiva para gestión del POS y consultas"
                technology "React + Next.js"
            }
            
            # Backend Monolítico Modular
            apiBackend = container "API Backend (Monolito Modular)" {
                description "Lógica de negocio: POS, clientes, inventario, llaves, parqueadero, pases, caja, reportes"
                technology "Node.js + Express"
            }
            
            # Base de Datos
            database = container "Database" {
                description "Almacenamiento centralizado de todas las entidades"
                technology "PostgreSQL"
                tags "database"
            }
            
            # Microservicio Chatbot (Independiente)
            chatbotService = container "Analyst Chatbot Service" {
                description "Bot analista con NLP para consultas de métricas (producto modular vendible)"
                technology "Python + FastAPI"
            }
            
            chatbotDB = container "Chatbot Database" {
                description "Historial de conversaciones, configuraciones por cliente"
                technology "PostgreSQL"
                tags "database"
            }
            
            # Container-level relationships (internas)
            webApp -> apiBackend "Hace requests API" "HTTPS/REST"
            apiBackend -> database "Lee/Escribe" "SQL"
            
            chatbotService -> apiBackend "Obtiene datos de negocio" "HTTPS/REST API"
            chatbotService -> chatbotDB "Almacena conversaciones" "SQL"
            
            # Container to External Systems relationships
            chatbotService -> whatsapp "Envía respuestas/reportes" "WhatsApp Business API"
            chatbotService -> llm "Procesa lenguaje natural" "API"
        }
        
        # System Context relationships (incluyen actors y sistemas externos)
        admin -> webApp "Gestiona POS"
        admin -> whatsapp "Realiza consultas sobre el negocio"
        staff -> webApp "Opera POS"
        
        whatsapp -> chatbotService "Reenvía consultas" "WhatsApp Business API"
        whatsapp -> admin "Responde"
        
        apiBackend -> client "Envía comprobantes por email" "SMTP"
        apiBackend -> admin "Envía reportes por email" "SMTP"
    }
    
    views {
        systemContext zeroStressSystem {
            include *
            autoLayout
        }
        
        container zeroStressSystem {
            include *
            animation {
                webApp apiBackend database
                chatbotService chatbotDB
                whatsapp llm
                admin staff client
            }
            autoLayout tb 500 500
        }
        
        styles {
            element "Element" {
                shape roundedbox
                background #2f75dd
                color #ffffff
            }
            element "external" {
                background #8d9197
                color #ffffff
            }
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "database" {
                shape Cylinder
                background #438dd5
                color #ffffff
            }
        }
    }
}