# Flutter - BrasilCard Private  
## Desafio Técnico - BrasilCripto

Este projeto foi desenvolvido utilizando a versão estável do Flutter **3.32.0**.

### 🗂 Estrutura de Pastas

- **core/**: Utilitários e funcionalidades transversais usadas em toda a aplicação.
- **data/**: Camada de implementação. Contém chamadas de API (`datasources`), modelos (`models`) e implementação dos repositórios (`repositories`).
- **domain/**: Camada de regras de negócio. Define entidades puras, contratos de repositórios e casos de uso.
- **presentation/**: Camada de UI. Inclui viewmodels (lógica de estado), páginas e widgets reutilizáveis.
- **services/**: Serviços auxiliares como persistência local (ex: favoritos via `SharedPreferences`).
- **main.dart / app.dart**: Entry point e configuração de rotas/temas.