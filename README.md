# ProVerif Docker Setup and Usage

This repository contains Docker configurations for running ProVerif formal verification tools to analyze access control protocols.

## Prerequisites

- Docker installed on your system
- Git (for cloning repositories)

## Setup Options

### Option 1: Using the Pre-built Docker Image (Recommended)

Use the convenient shell script wrapper:

```bash
# Make the script executable
chmod +x proverif.sh

# Run ProVerif on a model file
./proverif.sh your_model.pv
```

### Option 2: Building from Source

If you prefer to build the Docker image yourself:

```bash
# Build the Docker image
docker build -t vtt-qx-proverif .

# Run the container interactively
docker run -it --rm -v $(pwd):/home/proverif/models vtt-qx-proverif

# Inside the container, you can run ProVerif
proverif your_model.pv
```

## Usage Examples

### Running Protocol Verification

```bash
# Verify device access control protocol
./proverif.sh device_access_control.pv

# Verify job submission protocol
./proverif.sh job_submission.pv

# Verify project token protocol
./proverif.sh project_token.pv

# Verify proxy authentication protocol
./proverif.sh proxy_authentication.pv

# Verify Zero Trust access control
./proverif.sh zero_trust.pv
```

### Interactive Development

For developing and testing models interactively:

```bash
# Start an interactive container
docker run -it --rm -v $(pwd):/home/proverif/models vtt-qx-proverif

# Inside the container, you have access to:
# - ProVerif compiler: proverif
# - Text editor: nano
# - Your local files mounted in /home/proverif/models
```

## File Structure

```
├── Dockerfile              # Docker image definition
├── proverif.sh             # Convenient wrapper script
├── models/                 # Your ProVerif models go here
│   ├── device_access.pv
│   ├── job_submission.pv
│   └── ...
└── README.md              # This file
```

## ProVerif Model Development

### Basic Model Structure

ProVerif models typically follow this structure:

```proverif
(* Types *)
type user.
type device.
type project.

(* Events *)
event DeviceAccessGranted(user, device).

(* Processes *)
let deviceAccess(u: user, d: device) = 
    (* Protocol logic here *)
    event DeviceAccessGranted(u, d).

(* Security Queries *)
query x: user, y: device; 
    event(DeviceAccessGranted(x, y)).

(* Main process *)
process deviceAccess(alice, device1)
```

### Verification Output

ProVerif will output:
- ✅ `RESULT goal is true` - Property verified successfully
- ❌ `RESULT goal is false` - Property violated (with attack trace)
- ⚠️ `RESULT goal cannot be proved` - Inconclusive result

## Troubleshooting

### Common Issues

1. **Permission denied on proverif.sh**
   ```bash
   chmod +x proverif.sh
   ```

2. **File not found in container**
   - Ensure your `.pv` files are in the same directory as `proverif.sh`
   - Check that file paths don't contain spaces

3. **ProVerif syntax errors**
   - Verify your model syntax against ProVerif documentation
   - Check for missing semicolons or incorrect type definitions

### Docker Issues

1. **Container fails to start**
   ```bash
   # Check Docker is running
   docker --version
   
   # Pull base image manually if needed
   docker pull ubuntu:20.04
   ```

2. **Build failures**
   ```bash
   # Clean Docker cache and rebuild
   docker system prune -f
   docker build --no-cache -t vtt-qx-proverif .
   ```

## Development Workflow

1. **Write your ProVerif model** in a `.pv` file
2. **Run verification** using `./proverif.sh model.pv`
3. **Analyze results** and refine your model
4. **Iterate** until all security properties are verified

## Additional Resources

- [ProVerif Manual](https://bblanche.gitlabpages.inria.fr/proverif/)

## Support

For issues related to:
- **ProVerif syntax/semantics**: Consult the ProVerif manual
- **Docker setup**: Check Docker documentation