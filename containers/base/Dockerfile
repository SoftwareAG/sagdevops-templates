FROM centos:7

ENV SAG_HOME=/opt/softwareag

# Create sagadmin a process owner and group
RUN groupadd -g 1724 sagadmin && \
    useradd -u 1724 -m -g 1724 -d $SAG_HOME -c "SoftwareAG Admin" sagadmin
