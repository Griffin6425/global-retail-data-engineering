.PHONY: help install install-dev install-all format lint test clean

help:
	@echo "Available commands:"
	@echo "  make install       - Install core dependencies"
	@echo "  make install-dev   - Install with dev dependencies"
	@echo "  make install-all   - Install all dependencies"
	@echo "  make format        - Format code with black"
	@echo "  make lint          - Lint code with ruff"
	@echo "  make test          - Run tests"
	@echo "  make clean         - Remove generated files"

# 安装核心依赖
install:
	uv pip install -e .

# 安装开发依赖
install-dev:
	uv pip install -e ".[dev]"

# 安装所有依赖
install-all:
	uv pip install -e ".[all]"

# 代码格式化
format:
	black src/ tests/
	ruff check --fix src/ tests/

# 代码检查
lint:
	black --check src/ tests/
	ruff check src/ tests/
	mypy src/

# 运行测试
test:
	pytest tests/ -v

# 清理生成的文件
clean:
	rm -rf build/ dist/ *.egg-info/
	rm -rf .pytest_cache/ .coverage htmlcov/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete