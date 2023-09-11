From mcr.microsoft.com/dotnet/sdk:7.0 As build-env
Workdir /app
Expose 80
Expose 433

copy *.csproj ./
Run dotnet restore

copy . ./
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/sdk:7.0
WORKDIR /app
copy --from=build-env /app/out .
ENTRYPOINT ["dotnet","FormulaOneK8s.dll"]